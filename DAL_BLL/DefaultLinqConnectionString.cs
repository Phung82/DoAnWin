using System;

namespace DAL_BLL
{
    public static class DefaultLinqConnectionString
    {
        public static String UDF_DefaultLinqConnectionString()
        {
            return Properties.Settings.Default.dbQLQCFConn.ToString().Trim();
        }
    }
}
