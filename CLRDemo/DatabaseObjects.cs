using System;
using Microsoft.SqlServer.Server;
using System.Collections;
using System.Data.SqlClient;
using System.Globalization;

namespace CSTruter.com
{
    public class functions
    {
        [SqlFunction(DataAccess = DataAccessKind.None)]
        public static String Trim([SqlFacet(MaxSize = -1)]String value)
        {
            return value.Trim();
        }

        [SqlFunction(DataAccess = DataAccessKind.None, FillRowMethodName = "FillRow")]
        public static IEnumerable Split([SqlFacet(MaxSize = 10)]String separator, [SqlFacet(MaxSize = -1)]String value)
        {
            Int32 i = 0;
            String[] values = value.Split(new String[] { separator }, StringSplitOptions.None);
            foreach (String v in values)
            {
                yield return new Object[] { i++, v };
            }
        }

        public static void FillRow(Object sender, out Int32 id, out String value)
        {
            Object[] values = (Object[])sender;
            id = (Int32)values[0];
            value = (String)values[1];
        }
    }

    public class Procedures
    {
        [SqlProcedure]
        public static void viewFriends()
        {
            using (SqlConnection connection = new SqlConnection("context connection=true"))
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT firstname, lastname FROM friends", connection);
                SqlDataReader reader = command.ExecuteReader();
                SqlContext.Pipe.Send(reader);
            }
        }

        [SqlProcedure]
        public static void getDayNames([SqlFacet(MaxSize = 10)]String name)
        {
            SqlDataRecord record = new SqlDataRecord(new SqlMetaData[] 
            { 
                new SqlMetaData("id", System.Data.SqlDbType.Int), 
                new SqlMetaData("value", System.Data.SqlDbType.VarChar, 255)
            });

            CultureInfo culture = new CultureInfo(name);
            String[] DayNames = culture.DateTimeFormat.DayNames;

            SqlContext.Pipe.SendResultsStart(record);
            for (int i = 0; i < DayNames.Length; i++)
            {
                record.SetInt32(0, i);
                record.SetSqlString(1, DayNames[i]);
                SqlContext.Pipe.SendResultsRow(record);
            }
            SqlContext.Pipe.SendResultsEnd();
        }
    }
}
