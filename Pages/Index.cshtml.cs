using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Net.Http;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Newtonsoft.Json;
using DB_Lab2.Services;
using Microsoft.AspNetCore.Http.HttpResults;
using Newtonsoft.Json.Linq;
using static DB_Lab2.Pages.IndexModel;

namespace DB_Lab2.Pages
{
    [IgnoreAntiforgeryToken]
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;
        private readonly DBService _dbService;

        public IndexModel(ILogger<IndexModel> logger, DBService dbService)
        {
            _logger = logger;
            _dbService = dbService;
        }

        public void OnGet()
        {

        }
    }
}
