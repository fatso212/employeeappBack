using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EmployeeAppBack.DAL;
using EmployeeAppBack.Models;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace EmployeeAppBack.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("CorsPolicy")]
    
    public class AccountsController : ControllerBase
    {
        private DALAccounts account;
        public AccountsController(DALAccounts account)
        {
            this.account = account;
        }

        // GET api/Accounts/Accounts
        [HttpGet]
        public ActionResult<List<Account>> Get()
        {
            return account.GetAccounts();
        }

        // POST api/values
        [HttpPost("AddAccount")]
        public void Post([FromBody] Account newaccount)
        {
            account.AddAccount(newaccount);
        }

        //// GET api/values/5
        //[HttpGet("{id}")]
        //public ActionResult<string> Get(int id)
        //{
        //    return "value";
        //}

        //// PUT api/values/5
        //[HttpPut("{id}")]
        //public void Put(int id, [FromBody] string value)
        //{
        //}

        //// DELETE api/values/5
        //[HttpDelete("{id}")]
        //public void Delete(int id)
        //{
        //}
    }
}
