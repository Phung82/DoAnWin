using DAL_BLL;
using DevExpress.XtraCharts;
using System;
using System.Windows.Forms;

namespace ThietKeChucNang
{
    public partial class ucThongKeTopPick : UserControl
    {
        BLL_ThongKe bllThongKe = new BLL_ThongKe();
        public ucThongKeTopPick()
        {
            InitializeComponent();
        }
        public void LoadThongKeTopPick()
        {
            chartControlTopPick.DataSource = bllThongKe.LoadThongKeTopPick();
            Series s1 = new Series("Tên đồ uống", ViewType.Bar);
            s1.ArgumentDataMember = "TenDoUong";
            s1.ValueDataMembers.AddRange("SoLuong");
            chartControlTopPick.Series.Add(s1);
        }
        private void ucThongKeTopPick_Load(object sender, EventArgs e)
        {
            LoadThongKeTopPick();
        }
    }
}
