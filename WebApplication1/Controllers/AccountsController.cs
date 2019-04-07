using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApplication1.dals;
using WebApplication1.Models;

namespace WebApplication1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("CorsPolicy")]
    public class AccountsController : ControllerBase
    {
        [Route("Add")]
        [HttpPost]
        public ActionResult<Account> GetAccount([FromForm]Account account)
        {
            new DAL().addAccount(account);
            return account;
        }

        [Route("Get")]
        [HttpGet]
        public ActionResult<string> GetAccounts()
        {
            return JsonConvert.SerializeObject(new DAL().GetAccounts());
        }
    }
}