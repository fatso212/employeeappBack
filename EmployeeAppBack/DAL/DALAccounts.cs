using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using EmployeeAppBack.Models;

namespace EmployeeAppBack.DAL
{
    public class DALAccounts
    {
        private readonly string connectionString;

        public DALAccounts(string connectionString)
        {
            this.connectionString = connectionString;
        }
        public List<Account> GetAccounts()
        {
            List<Account> accounts = new List<Account>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(@"SELECT * FROM Accounts", conn);

                    var reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        accounts.Add(
                            new Account
                            {
                                AccountDescription = Convert.ToString(reader["AccountDescription"]),
                                AccountLogo = Convert.ToString(reader["AccountLogo"]),
                                AccountName = Convert.ToString(reader["AccountName"]),
                                AccountID = Convert.ToInt32(reader["AccountID"])
                            }
                        );
                    }
                }
            }

            catch (SqlException ex)
            {
                throw ex;
            }

            return accounts;
        }
        public void AddAccount(Account account)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(@"INSERT INTO Accounts(AccountName, AccountDescription, AccountLogo) VALUES (@AccountName, @AccountDescription, @AccountLogo)", conn);
                    cmd.Parameters.AddWithValue("@AccountName", account.AccountName);
                    cmd.Parameters.AddWithValue("@AccountDescription", account.AccountDescription);
                    cmd.Parameters.AddWithValue("@AccountLogo", account.AccountLogo);

                    cmd.ExecuteNonQuery();
                }
            }

            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}
