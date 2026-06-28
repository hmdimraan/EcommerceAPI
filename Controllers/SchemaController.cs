using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
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
              _configuration.GetConnectionString("MariaDBConnection");






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

           
            return Ok(new
            {
                Message =
                    "Schema scanned successfully and MongoDB collections created.",
                Schema = result
            });
        }
    }
}