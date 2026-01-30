using System;
using System.Web;

namespace Agriculture_Equipment_Store
{
    public partial class Admin_logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear session
            Session.Clear();
            Session.Abandon();

            // Clear cookies
            if (Request.Cookies["ASP.NET_SessionId"] != null)
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);

            // Prevent browser caching
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // Show message for 2 seconds, then redirect
            Page.Header.Controls.Add(new System.Web.UI.LiteralControl(
                "<meta http-equiv='refresh' content='2;URL=login.aspx' />"
            ));
        }
    }
}
