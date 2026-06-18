using Microsoft.Data.SqlClient;

namespace EcommerceAPI
{
    public class SchemaScanner
    {
        private readonly string _connectionString;

        public SchemaScanner(string connectionString)
        {
            _connectionString = connectionString;
        }

        public List<string> GetTables()
        {
            var tables = new List<string>();

            using SqlConnection conn = new SqlConnection(_connectionString);

            conn.Open();// connection established - within db and .net

            using SqlCommand cmd =
                         new SqlCommand("GetAllTables", conn);

            cmd.CommandType =
                System.Data.CommandType.StoredProcedure;

            using SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                tables.Add(reader.GetString(0));
            }

            return tables;
        }
    }
}