using DB_Lab2.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using static DB_Lab2.Pages.AddModel;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace DB_Lab2.Pages
{
    [IgnoreAntiforgeryToken]
    public class AddModel : PageModel
    {
        private readonly ILogger<AddModel> _logger;
        private readonly DBService _dbService;
        public AddModel(ILogger<AddModel> logger, DBService dbService)
        {
            _logger = logger;
            _dbService = dbService;
        }

        [BindProperty]
        public Account AccountModel { get; set; }

        [BindProperty]
        public Clients ClientModel { get; set; }

        [BindProperty]
        public Contract ContractModel { get; set; }

        [BindProperty]
        public Worker WorkerModel { get; set; }

        public class Account
        {
            public string saskaitos_numeris { get; set; }
            public decimal balansas { get; set; }
            public decimal? dienos_limitas { get; set; }
            public decimal? savaites_limitas { get; set; }
            public decimal? menesio_limitas { get; set; }
            public string saskaitos_tipas { get; set; }
            public string valiuta { get; set; }
        }

        public class Clients
        {
            public string ID_asmensKodas {  get; set; }
        }

        public class Contract
        {
            public string sutarties_tipas { get; set; }
            [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
            public DateTime data { get; set; }
            public string busena { get; set; }
        }

        public class Worker
        {
            public string ID_asmensKodas { get; set; }
        }

        public class FormAddData
        {
            public Account bankoSaskaitaData { get; set; }
            public string pasirinktasKlientas { get; set; }
            public List<Contract>? sutartys { get; set; }
            public List<string>? pasirinktasDarbuotojas { get; set; }
        }

        public async Task<IActionResult> OnGet()
        {

            List<string> saskaitosTipai = await _dbService.GetAccountType();
            ViewData["saskaitosTipai"] = new SelectList(saskaitosTipai);

            List<string> valiutuTipai = await _dbService.GetCurrency();
            ViewData["valiutuTipai"] = new SelectList(valiutuTipai);

            List<string> klientai = await _dbService.GetClients();
            ViewData["klientai"] = new SelectList(klientai);

            List<string> sutartiesTipai = await _dbService.GetContracts();
            ViewData["sutartiesTipai"] = new SelectList(sutartiesTipai);

            List<string> busenuTipai = await _dbService.GetStatus();
            ViewData["busenuTipai"] = new SelectList(busenuTipai);

            List<string> darbuotojai = await _dbService.GetWorkers();
            ViewData["darbuotojai"] = new SelectList(darbuotojai);

            if(saskaitosTipai.Count == 0 || valiutuTipai.Count == 0 || sutartiesTipai.Count == 0 || busenuTipai.Count == 0)
            {
                return RedirectToPage("/Error");
            }

            return Page();
        }
        public async Task<IActionResult> OnPostSetNewDataAsync([FromBody] FormAddData data)
        {
            try
            {
                bool status = await _dbService.AddData(data);
                if (status)
                {
                    return StatusCode(200);
                }
                else
                {
                    return StatusCode(500);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return StatusCode(500, "Error occured in OnPostUpdateDataAsync method: " + ex.Message);
            }
        }
    }
}
