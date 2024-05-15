using Microsoft.AspNetCore.Mvc;
using System.Text.RegularExpressions;
using System.Text;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using static DB_Lab2.Pages.EditModel;
using static DB_Lab2.Pages.AddModel;
using System.Collections.Generic;
using System.Text.Json;
using DB_Lab2.Pages;
namespace DB_Lab2.Services
{
    public class DBService
    {
        private readonly ILogger<DBService> _logger;
        public DBService(ILogger<DBService> logger)
        {
            _logger = logger;
        }
        public async Task<string> ParseF1(string jsonPayload)
        {
            string apiUrl = "http://127.0.0.1:5001/get_F1";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    httpClient.DefaultRequestHeaders.Add("registered", "application/json");
                    var content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");
                    var response = await httpClient.PostAsync(apiUrl, content);
                    string responseContent = await response.Content.ReadAsStringAsync();
                    responseContent = Regex.Unescape(responseContent);
                    if (response.IsSuccessStatusCode)
                    {
                        return responseContent;
                    }
                    return String.Empty;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return String.Empty;
            }
        }

        public async Task<string> GetAccountData(string accountNumber)
        {
			string apiUrl = $"http://127.0.0.1:5001/get_account/{accountNumber}";
			try
			{
				using (var httpClient = new HttpClient())
				{
					var response = await httpClient.GetAsync(apiUrl);
					string responseContent = await response.Content.ReadAsStringAsync();
					responseContent = Regex.Unescape(responseContent);
					if (response.IsSuccessStatusCode)
					{
						return responseContent.ToString();
					}
					return String.Empty;
				}
			}
			catch (Exception ex)
			{
                _logger.LogError(ex.Message);
                return String.Empty;
			}
		}

        public async Task<List<string>> GetClients()
        {
            string apiUrl = "http://127.0.0.1:5001/get_clients";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        string responseContent = await response.Content.ReadAsStringAsync();
                        responseContent = Regex.Unescape(responseContent);
                        var responseObject = JsonConvert.DeserializeObject<Dictionary<string, List<string>>>(responseContent);
                        if (responseObject.TryGetValue("clients", out List<string> clients))
                        {
                            return clients;
                        }
                    }
                    return new List<string>();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return new List<string>();
            }
        }

        public async Task<string> GetClient(string accountNumber)
        {
            string apiUrl = $"http://127.0.0.1:5001/get_client/{accountNumber}";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    string responseContent = await response.Content.ReadAsStringAsync();
                    responseContent = Regex.Unescape(responseContent);
                    if (response.IsSuccessStatusCode)
                    {
                        return responseContent.ToString();
                    }
                    return String.Empty;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return String.Empty;
            }
        }

        public async Task<List<List<string>>> GetAccountContracts(string accountNumber)
        {
            string apiUrl = $"http://127.0.0.1:5001/get_account_contracts/{accountNumber}";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    string responseContent = await response.Content.ReadAsStringAsync();
                    responseContent = Regex.Unescape(responseContent);
                    if (response.IsSuccessStatusCode)
                    {
                        var contracts = System.Text.Json.JsonSerializer.Deserialize<List<List<string>>>(responseContent);
                        return contracts;
                    }
                    return new List<List<string>>();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return new List<List<string>>();
            }
        }

        public async Task<List<string>> GetAccountType()
        {
            string apiUrl = "http://127.0.0.1:5001/get_accout_type";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        string responseContent = await response.Content.ReadAsStringAsync();
                        responseContent = Regex.Unescape(responseContent);
                        var responseObject = JsonConvert.DeserializeObject<Dictionary<string, List<string>>>(responseContent);
                        if (responseObject.TryGetValue("saskaitos_tipas", out List<string> saskaitosTipas))
                        {
                            return saskaitosTipas;
                        }
                    }
                    return new List<string>();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return new List<string>();
            }
        }

        public async Task<List<string>> GetCurrency()
        {
            string apiUrl = "http://127.0.0.1:5001/get_currency";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        string responseContent = await response.Content.ReadAsStringAsync();
                        responseContent = Regex.Unescape(responseContent);
                        var responseObject = JsonConvert.DeserializeObject<Dictionary<string, List<string>>>(responseContent);
                        if (responseObject.TryGetValue("valiuta", out List<string> valiuta))
                        {
                            return valiuta;
                        }
                    }
                    return new List<string>();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return new List<string>();
            }
        }

        public async Task<List<string>> GetContracts()
        {
            string apiUrl = "http://127.0.0.1:5001/get_contracts";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        string responseContent = await response.Content.ReadAsStringAsync();
                        responseContent = Regex.Unescape(responseContent);
                        var responseObject = JsonConvert.DeserializeObject<Dictionary<string, List<string>>>(responseContent);
                        if (responseObject.TryGetValue("sutartis", out List<string> sutartis))
                        {
                            return sutartis;
                        }
                    }
                    return new List<string>();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return new List<string>();
            }
        }

        public async Task<List<string>> GetStatus()
        {
            string apiUrl = "http://127.0.0.1:5001/get_status";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        string responseContent = await response.Content.ReadAsStringAsync();
                        responseContent = Regex.Unescape(responseContent);
                        var responseObject = JsonConvert.DeserializeObject<Dictionary<string, List<string>>>(responseContent);
                        if (responseObject.TryGetValue("busena", out List<string> busena))
                        {
                            return busena;
                        }
                    }
                    return new List<string>();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return new List<string>();
            }
        }

        public async Task<List<string>> GetWorkers()
        {
            string apiUrl = "http://127.0.0.1:5001/get_workers";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    if (response.IsSuccessStatusCode)
                    {
                        string responseContent = await response.Content.ReadAsStringAsync();
                        responseContent = Regex.Unescape(responseContent);
                        var responseObject = JsonConvert.DeserializeObject<Dictionary<string, List<string>>>(responseContent);
                        if (responseObject.TryGetValue("workers", out List<string> workers))
                        {
                            return workers;
                        }
                    }
                    return new List<string>();
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return new List<string>();
            }
        }

		public async Task<bool> AddData(FormAddData data)
		{
			string apiUrl = "http://127.0.0.1:5001/add_account_contract";
			try
			{
				using (var httpClient = new HttpClient())
				{
					httpClient.DefaultRequestHeaders.Add("add", "application/json");
					var content = new StringContent(JsonConvert.SerializeObject(data), Encoding.UTF8, "application/json");
					var response = await httpClient.PostAsync(apiUrl, content);
					return response.IsSuccessStatusCode;
				}
			}
			catch (Exception ex)
			{
                _logger.LogError(ex.Message);
                return false;
			}
		}

        public async Task<bool> UpdateData(FormEditData data)
        {
            string apiUrl = "http://127.0.0.1:5001/edit_account_contract";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    httpClient.DefaultRequestHeaders.Add("edit", "application/json");
                    var content = new StringContent(JsonConvert.SerializeObject(data), Encoding.UTF8, "application/json");
                    var response = await httpClient.PostAsync(apiUrl, content);
                    return response.IsSuccessStatusCode;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return false;
            }
        }

        public async Task<bool> RemoveF1Account(string accountNumber)
        {
            string apiUrl = $"http://127.0.0.1:5001/remove_F1_account/{accountNumber}";
            try
            {
                using (var httpClient = new HttpClient())
                {
                    var response = await httpClient.GetAsync(apiUrl);
                    string responseContent = await response.Content.ReadAsStringAsync();
                    responseContent = Regex.Unescape(responseContent);
                    if (response.IsSuccessStatusCode)
                    {
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message);
                return false;
            }
        }
    }
}