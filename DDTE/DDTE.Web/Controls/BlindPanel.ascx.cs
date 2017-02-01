using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DDTE.Web.Controls
{
    public partial class BlindPanel : System.Web.UI.UserControl
    {
        public event EventHandler SmallSizeAction;
        public event EventHandler MediumSizeAction;
        public event EventHandler LargeSizeAction;
        public event EventHandler BlackOnWhiteAction;
        public event EventHandler WhiteOnBlackAction;
        public event EventHandler StandardBgAction;
        bool executedControlAction = false;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            pnlBlind.Style[HtmlTextWriterStyle.Display] = executedControlAction ? "" : "none";
        }

        protected void btnSmallText_Click(object sender, EventArgs e)
        {
            executedControlAction = true;
            if (SmallSizeAction != null)
            {
                SmallSizeAction(sender, e);
            }
        }

        protected void btnMediumText_Click(object sender, EventArgs e)
        {
            executedControlAction = true;
            if (MediumSizeAction != null)
            {
                MediumSizeAction(sender, e);
            }
        }

        protected void btnLargeText_Click(object sender, EventArgs e)
        {
            executedControlAction = true;
            if (LargeSizeAction != null)
            {
                LargeSizeAction(sender, e);
            }
        }

        protected void btnBlackWhite_Click(object sender, EventArgs e)
        {
            executedControlAction = true;
            if (BlackOnWhiteAction != null)
            {
                BlackOnWhiteAction(sender, e);
            }
        }

        protected void btnWhiteBlack_Click(object sender, EventArgs e)
        {
            executedControlAction = true;
            if (WhiteOnBlackAction != null)
            {
                WhiteOnBlackAction(sender, e);
            }
        }

        protected void btnStandardColor_Click(object sender, EventArgs e)
        {
            executedControlAction = true;
            if (StandardBgAction != null)
            {
                StandardBgAction(sender, e);
            }
        }
    }
}