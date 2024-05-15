using DB_Lab2.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json.Linq;
using static DB_Lab2.Pages.Banko_saskaitosModel;

namespace DB_Lab2.Pages
{
    [IgnoreAntiforgeryToken]
    public class Banko_saskaitosModel : PageModel
    {
        private readonly ILogger<Banko_saskaitosModel> _logger;
        private readonly DBService _dbService;

        public Banko_saskaitosModel(ILogger<Banko_saskaitosModel> logger, DBService dbService)
        {
            _logger = logger;
            _dbService = dbService;
        }
        public void OnGet()
        {
        }

        public class ResponseModel
        {
            public List<Dictionary<string, string>?>? RowData { get; set; }
        }

        public async Task<IActionResult> OnPostParseDataAsync()
        {
            try
            {
                string jsonPayload = @"
                {
                    ""main"": ""banko_saskaitos"",
                    ""main_fk"": ""fk_klientaskliento_ID"",
                    ""additional"": ""klientai"",
                    ""additional_pk"": ""kliento_ID"",
                    ""order_by"": ""fk_klientaskliento_ID""
                }";

                var response = await _dbService.ParseF1(jsonPayload);

                var responseModel = new ResponseModel();
                var jsonArray = JArray.Parse(response);

                responseModel.RowData = jsonArray.Skip(0).Select(item =>
                {
                    var rowData = item.ToObject<Dictionary<string, string>>();
                    return rowData;
                }).ToList();

                return StatusCode(200, responseModel);
            }
            catch (Exception ex)
			{
                _logger.LogError(ex.Message);
                return StatusCode(404);
			}
        }

		public async Task<IActionResult> OnPostRemoveDataAsync([FromBody] string accountNumber)
		{
            try
            {
				bool status = await _dbService.RemoveF1Account(accountNumber);
                if (status) 
                {
					return StatusCode(200);
				}
				return StatusCode(500);
			}
            catch (Exception ex) 
            {
                _logger.LogError(ex.Message);
				return StatusCode(500);
			}
		}
	}
}
