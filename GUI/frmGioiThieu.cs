using DAL_BLL;
using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;
namespace ThietKeChucNang
{
    public partial class frmGioiThieu : Form
    {
        BLL_CaiDat bllCaiDat = new BLL_CaiDat();
        public frmGioiThieu()
        {
            InitializeComponent();
        }
        [DllImport("user32.DLL", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.DLL", EntryPoint = "SendMessage")]
        private extern static void SendMessage(System.IntPtr hWnd, int wMsg, int wParam, int lParam);
        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void pnlThanhTieuDe_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(this.Handle, 0x112, 0xf012, 0);
        }

        private void frmGioiThieu_Load(object sender, EventArgs e)
        {
            string themeColor = bllCaiDat.GetThemeColor();
            pnlThanhTieuDe.BackColor = pnlLeft.BackColor = pnlRight.BackColor = pnlBottom.BackColor = lblTenUngDung.ForeColor = lblTacGia.ForeColor = lblPhienBan.ForeColor = lblBanQuyen.ForeColor = lblLienHe.ForeColor = bllCaiDat.SelectThemeColor(themeColor);
        }
    }
}
