using DAL_BLL;
using System;
using System.Windows.Forms;
namespace GUI
{
    public partial class frmConfig : Form
    {
        BLL_UserManagement CauHinh = new BLL_UserManagement();
        public frmConfig()
        {
            InitializeComponent();
        }
        private void cboServername_DropDown(object sender, EventArgs e)
        {
            cboServername.DataSource = CauHinh.GetServerName();
            cboServername.DisplayMember = "Servername";
        }

        private void cboDatabase_DropDown(object sender, EventArgs e)
        {
            cboDatabase.DataSource = CauHinh.GetDBName(cboServername.Text, txtUsername.Text, txtPassword.Text);
            cboDatabase.DisplayMember = "Name";
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            CauHinh.SaveConfig(cboServername.Text, txtUsername.Text, txtPassword.Text, cboDatabase.Text);
            //CauHinh.SaveLinqConfig(cboServername.Text, txtUsername.Text, txtPassword.Text, cboDatabase.Text);
            MessageBox.Show("Đã lưu! Khởi động lại ứng dụng để cập nhật chuỗi kết nối!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            Application.Exit();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void frmConfig_Load(object sender, EventArgs e)
        {

        }
    }
}
