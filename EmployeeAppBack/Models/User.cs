using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeAppBack.Models
{
    public class Users
    {
        public int UserID { get; set; }
        public int AccountID { get; set; }
        public string UserType { get; set; }
        public string UserName { get; set; }
        public string PasswordString { get; set; }
        public string Salt { get; set; }
        public string UserEmailAddress { get; set; }
        public string UserFirstName { get; set; }
        public string UserLastName { get; set; }
        public string UserPhoneNumber { get; set; }
    }
}
