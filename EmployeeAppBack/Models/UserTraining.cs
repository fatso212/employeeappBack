using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeAppBack.Models
{
    public class UserTraining
    {
        public int UserTrainingID { get; set; }

        public int UserID { get; set; }

        public int TrainingID { get; set; }

        public string TrainingStatus { get; set; }
    }
    
}
