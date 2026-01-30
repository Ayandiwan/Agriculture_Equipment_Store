using System;
using System.Web;

namespace Agriculture_Equipment_Store
{
    public partial class Admin_check : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Disable caching for all admin pages
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // Skip session check for logout page
            string path = Request.Url.AbsolutePath.ToLower();
            if (!path.Contains("admin_logout.aspx") && Session["AdminUser"] == null)
            {
                Response.Redirect("~/login.aspx");
            }
        }
    }
}
