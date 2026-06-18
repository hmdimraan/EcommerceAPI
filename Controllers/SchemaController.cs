using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using MongoDB.Driver;
using System.Xml.Linq;

namespace EcommerceAPI.Controllers
{
    [ApiController]//Tells ASP.NET that this class is an API controller.
    [Route("api/[controller]")]
    public class SchemaController : ControllerBase
    {
        private readonly IConfiguration _configuration;
    
        public SchemaController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpPost("sync-to-mongodb")]//API end point
        public IActionResult SyncSchemaToMongo()
        {
            string sqlConnectionString =
                _configuration.GetConnectionString("DefaultConnection");

            string mongoConnectionString =
       _configuration.GetConnectionString("MongoConnection");

            string mongoDatabaseName =
                "EcommerceMongo";

            var mongoClient =
                new MongoClient(mongoConnectionString);//connects to mongodb server running on localhost at port 27017

            var mongoDatabase =
                mongoClient.GetDatabase(mongoDatabaseName);
            // returns IMongoDatabase object - IMongoDatabase { Name = "EcommerceMongo"}
            var result = new List<object>();

            using SqlConnection conn =
                new SqlConnection(sqlConnectionString);

            conn.Open();

            using SqlCommand tableCmd =
            new SqlCommand("GetAllTables", conn);//command text , connection , commandtype

              tableCmd.CommandType =
                System.Data.CommandType.StoredProcedure;

            using SqlDataReader tableReader =
                tableCmd.ExecuteReader();//text , sp , tabledirect

            List<string> tables = new();

            while (tableReader.Read())
            {
                tables.Add(tableReader.GetString(0));;
            }

            tableReader.Close();//Only one reader can be active on connection at a time.

            foreach (string tableName in tables)
            {
                var existingCollections =
                    mongoDatabase
                    .ListCollectionNames()
                    .ToList();

                if (!existingCollections.Contains(tableName))
                {
                    mongoDatabase.CreateCollection(tableName);
                }
                //Verbatim string literal Allows multiline string

                string columnQuery = @"
                    SELECT
                        COLUMN_NAME,
                        DATA_TYPE,
                        IS_NULLABLE
                    FROM INFORMATION_SCHEMA.COLUMNS
                    WHERE TABLE_NAME = @TableName
                    ORDER BY ORDINAL_POSITION";
                //ORDINAL_POSITION represents the position of a column in the table.
                using SqlCommand columnCmd =
                    new SqlCommand(columnQuery, conn);
                //columnCmd Parameters[@TableName = "Products"]
                columnCmd.Parameters.AddWithValue(
                    "@TableName",
                    tableName);

                using SqlDataReader columnReader =
                    columnCmd.ExecuteReader();//exrecutes the query and returns the result rows

                List<object> columns = new();

                while (columnReader.Read())
                {
                    columns.Add(new
                    {
                        ColumnName =
                            columnReader["COLUMN_NAME"].ToString(),

                        DataType =
                            columnReader["DATA_TYPE"].ToString(),

                        IsNullable =
                            columnReader["IS_NULLABLE"].ToString()
                    });
                }

                columnReader.Close();

                result.Add(new
                {
                    Table = tableName,
                    Columns = columns
                });
            }

            return Ok(new
            {
                Message =
                    "Schema scanned successfully and MongoDB collections created.",
                Schema = result
            });
        }
    }
}