using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using WebApplication1.Models;

namespace WebApplication1.dals
{
    public class DAL
    {
        public void addAccount(Account account)
        {
            try
            {
                using (SqlConnection sc = new SqlConnection(db.connStr))
                {
                    sc.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO accounts(accountName) values(@name)", sc);
                    cmd.Parameters.AddWithValue("@name", account.AccountName);
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {

            }
        }

        public List<Account> GetAccounts()
        {
            List<Account> accounts = new List<Account>();
            try
            {
                using (SqlConnection sc = new SqlConnection(db.connStr))
                {
                    sc.Open();

                    SqlCommand cmd = new SqlCommand("SELECT * FROM accounts", sc);
                    SqlDataReader R = cmd.ExecuteReader();
                    while (R.Read())
                    {
                        accounts.Add(
                        new Account()
                        {
                            AccountID = Convert.ToInt32(R["accountID"]),
                            AccountName = Convert.ToString(R["accountName"])
                        });
                    }
                }
            }
            catch
            {

            }
            return accounts;
        }
    }
}
