using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeAppBack.Models
{
    public class TrainingFile
    {
        public int TrainingFileID { get; set; }
        public int TrainingID { get; set; }
        public int TrainingFileOrderNo { get; set; }
        public string TrainingFileDescription { get; set; }
        public string TrainingFilePath { get; set; }

    }
}
