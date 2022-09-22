using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;
using Microsoft.VisualBasic;

namespace SQLNET
{   
    public class MyNET
    {
        [Microsoft.SqlServer.Server.SqlFunction]
        public static SqlString MyPartition(long value,long start,long end,long range)
        {
            return Microsoft.VisualBasic.Interaction.Partition(value, start, end, range);
        }
        [Microsoft.SqlServer.Server.SqlFunction]
        public static SqlString T2S(string value)
        {
            return Microsoft.VisualBasic.Strings.StrConv(value, VbStrConv.SimplifiedChinese, 2052);
        }
        [Microsoft.SqlServer.Server.SqlFunction]
        public static SqlString S2T(string value)
        {
            return Microsoft.VisualBasic.Strings.StrConv(value, VbStrConv.TraditionalChinese, 2052);
        }
    }
}
