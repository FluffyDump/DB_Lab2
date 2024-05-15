using DB_Lab2.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.ComponentModel.DataAnnotations;
using static DB_Lab2.Pages.EditModel;

namespace DB_Lab2.Pages
{
    [IgnoreAntiforgeryToken]
    public class EditModel : PageModel
    {
        private readonly ILogger<EditModel> _logger;
        private readonly DBService _dbService;
        public EditModel(ILogger<EditModel> logger, DBService dbService)
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
            public string ID_asmensKodas { get; set; }
        }

        public class Contract
        {
            public string sutarties_ID { get; set; }
            public string sutarties_tipas { get; set; }
            [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
            public DateTime data { get; set; }
            public string busena { get; set; }
            public string pasirinktasDarbuotojas { get; set; }
        }

        public class Worker
        {
            public string ID_asmensKodas { get; set; }
        }

        public class FormData
        {
            public Account bankoSaskaitaData { get; set; }
        }

        public class FormEditData
        {
            public Account bankoSaskaitaData { get; set; }
            public List<Contract>? sutartys { get; set; }
        }

        public async Task<IActionResult> OnGet(string id)
        {
            if (id != null)
            {
                var accountData = await _dbService.GetAccountData(id);

                if (accountData != null)
                {
                    JObject jsonData = JObject.Parse(accountData);
                    var clientId = (int)jsonData["fk_klientaskliento_ID"];

                    AccountModel = JsonConvert.DeserializeObject<Account>(accountData);


                    if (ClientModel == null)
                    {
                        RedirectToPage("/Error");
                    }
                }
                else
                {
                    RedirectToPage("/Error");
                }
            }
            else
            {
                RedirectToPage("/Error");
            }

            List<List<string>> contractData = await _dbService.GetAccountContracts(AccountModel.saskaitos_numeris);

            var contracts = contractData.Select(contract => new Contract
            {
                sutarties_ID = contract[0].ToString(),
                sutarties_tipas = contract[1],
                data = DateTime.Parse(contract[2]),
                busena = contract[3],
                pasirinktasDarbuotojas = contract[4]
            }).ToList();


            ViewData["Contracts"] = contracts;

            List<string> saskaitosTipasValues = await _dbService.GetAccountType();
            ViewData["SaskaitosTipasDropdownOptions"] = new SelectList(saskaitosTipasValues);

            List<string> currencyValues = await _dbService.GetCurrency();
            ViewData["CurrencyDropdownOptions"] = new SelectList(currencyValues);

            string klientasStr = await _dbService.GetClient(AccountModel.saskaitos_numeris);
            klientasStr = klientasStr.Replace("\"", "");
            List<string> klientas = [klientasStr];
            ViewData["klientas"] = new SelectList(klientas);

            List<string> sutartiesTipai = await _dbService.GetContracts();
            ViewData["sutartiesTipai"] = new SelectList(sutartiesTipai);

            List<string> busenuTipai = await _dbService.GetStatus();
            ViewData["busenuTipai"] = new SelectList(busenuTipai);

            List<string> darbuotojai = await _dbService.GetWorkers();
            ViewData["darbuotojai"] = new SelectList(darbuotojai);

            return Page();
        }

        public async Task<IActionResult> OnPostUpdateDataAsync([FromBody] FormEditData data)
        {
            try
            {
                bool status = await _dbService.UpdateData(data);
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
                return StatusCode(500);
            }
        }
    }
}
