using System;
using System.Data;
using System.Web;

namespace Agriculture_Equipment_Store
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 🚫 Disable browser caching
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // 🔐 Restrict access for unauthenticated users
            string path = HttpContext.Current.Request.Url.AbsolutePath.ToLower();

            if (!path.Contains("login.aspx") &&
                !path.Contains("register.aspx") &&
                !path.Contains("default.aspx") &&
                !path.Contains("logout_coustomer.aspx"))
            {
                if (Session["user"] == null && Session["Role"] == null)
                {
                    Response.Redirect("~/login.aspx");
                }
            }

            // ✅ Update cart count every time page loads
            if (!IsPostBack)
            {
                UpdateCartCount();
            }
        }

        // ✅ Public method to update the cart item count badge
        public void UpdateCartCount()
        {
            try
            {
                int count = 0;

                // Example: if cart data is stored in Session as a DataTable or List
                if (Session["CartItems"] != null)
                {
                    if (Session["CartItems"] is DataTable dt)
                        count = dt.Rows.Count;
                    else if (Session["CartItems"] is System.Collections.Generic.List<int> list)
                        count = list.Count;
                }

                lblCartCount.InnerText = count.ToString();
            }
            catch
            {
                lblCartCount.InnerText = "0";
            }
        }
    }
}
