using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel.VNPAY
{
    public class PaymentInformationModel
    {
        public string OrderType { get; set; }
        public int Amount { get; set; }
        public string OrderDescription { get; set; }
        public string Name { get; set; }

    }
}
