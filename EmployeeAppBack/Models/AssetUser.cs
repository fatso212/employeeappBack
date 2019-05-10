using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace EmployeeAppBack.Models
{
    public class AssetUser
    {
        public int AssetsUserID { get; set; }
        public int AssetID { get; set; }
        public int UserID { get; set; }
        public DateTime UsersAssetsExperienceStart { get; set; }
        public DateTime UsersAssetsExperienceEnd { get; set; }
        public string UsersAssetsNotes { get; set; }
    }
}
