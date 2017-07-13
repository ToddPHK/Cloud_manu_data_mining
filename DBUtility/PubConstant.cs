using System;
using System.Configuration;

namespace DBUtility
{

    public class PubConstant
    {
        /// <summary>
        /// 获取连接字符串
        /// </summary>
        public static string ConnectionString
        {
            get
            {
                string _connectionString = ConfigurationManager.AppSettings["ConnectionString"];
                return _connectionString;
            }
        }

        public static string ConnectionString2
        {
            get
            {
                string _connectionString = ConfigurationManager.AppSettings["ConnectionString2"];
                return _connectionString;
            }
        }

        public static string ConnectionString3
        {
            get
            {
                string _connectionString = ConfigurationManager.AppSettings["ConnectionString3"];
                return _connectionString;
            }
        }
        /// <summary>
        /// 得到web.config里配置项的数据库连接字符串。
        /// </summary>
        /// <param name="configName"></param>
        /// <returns></returns>
        public static string GetConnectionString(string configName)
        {
            string connectionString = ConfigurationManager.AppSettings[configName];
            return connectionString;
        }


    }
}
