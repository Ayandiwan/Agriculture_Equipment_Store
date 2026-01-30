


using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Agriculture_Equipment_Store
{
    public partial class Admin_delete_product : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT ProductID, Name, Description, Price, Stock, Category, IsActive FROM Products", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        // Edit product
        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        // Update product
        protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            int productId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            string name = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
            string description = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
            decimal price = Convert.ToDecimal(((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].Cells[3].Controls[0]).Text);
            int stock = Convert.ToInt32(((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].Cells[4].Controls[0]).Text);
            string category = ((System.Web.UI.WebControls.TextBox)GridView1.Rows[e.RowIndex].Cells[5].Controls[0]).Text;

            SqlCommand cmd = new SqlCommand(
                "UPDATE Products SET Name=@Name, Description=@Description, Price=@Price, Stock=@Stock, Category=@Category WHERE ProductID=@ProductID", con);

            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@Price", price);
            cmd.Parameters.AddWithValue("@Stock", stock);
            cmd.Parameters.AddWithValue("@Category", category);
            cmd.Parameters.AddWithValue("@ProductID", productId);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            GridView1.EditIndex = -1;
            BindGrid();
        }

        // Cancel edit
        protected void GridView1_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }

        // Activate / Deactivate product
        protected void GridView1_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleStatus")
            {
                int productId = Convert.ToInt32(e.CommandArgument);

                SqlCommand cmd = new SqlCommand(
                    "UPDATE Products SET IsActive = CASE WHEN IsActive=1 THEN 0 ELSE 1 END WHERE ProductID=@ProductID", con);
                cmd.Parameters.AddWithValue("@ProductID", productId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                BindGrid();
            }
        }
    }
}

