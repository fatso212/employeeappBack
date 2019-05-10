using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeAppBack.Models
{
    public class Training
    {
        public int TrainingID { get; set; }
        public int AccountID { get; set; }
        public string TrainingName { get; set; }
        public string TrainingDescription { get; set; }
        public List<TrainingFile> TrainingFiles { get; set; }
    }
}
