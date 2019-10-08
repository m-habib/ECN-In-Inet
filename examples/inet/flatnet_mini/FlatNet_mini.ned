//
// Copyright (C) 2004 Andras Varga
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//




package inet.examples.inet.flatnet_mini;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;


network FlatNet_mini
{
    types:
        channel fiberline extends DatarateChannel
        {
            delay = 1us;
            datarate = 512Mbps;
        }
        channel ethernetline extends DatarateChannel
        {
            delay = 0.1us;
            datarate = 10Mbps;
        }
        channel ethernetline_fast extends DatarateChannel
        {
            delay = 0.001us;
            datarate = 1024Mbps;
        }
        channel ethernetline_slow extends DatarateChannel
        {
            delay = 10us;
            datarate = 0.1Mbps;
        }
    submodules:
        configurator: IPv4NetworkConfigurator {
            parameters:

                config = xml("<config> \
                				<interface hosts='cli1' address='192.168.0.37' netmask='255.255.x.x'/> \
                                <interface hosts='*' address='192.168.x.x' netmask='255.255.x.x'/> \
                                </config>");
        }
        rte[3]: Router {
            parameters:
                @display("is=vs");
        }
        cli1: StandardHost {
            parameters:
                @display("i=device/laptop_s");
        }
        //        cli_[30]: StandardHost {
        //            parameters:
        //                @display("i=device/laptop_s");
        //        }
        srv: StandardHost {
            parameters:
                @display("i=device/server_s");
        }
    connections:
        cli1.pppg++ <--> ethernetline_fast <--> rte[0].pppg++;
        rte[0].pppg++ <--> ethernetline_slow <--> rte[1].pppg++;
        rte[1].pppg++ <--> ethernetline_fast <--> rte[2].pppg++;
//        cli[1].pppg++ <--> ethernetline <--> rte[0].pppg++;

        //		for i = 0..29{
        //        	cli_[i].pppg++ <--> ethernetline_fast <--> rte[0].pppg++;
        //		}
        //        cli_[1].pppg++ <--> ethernetline_fast <--> rte[0].pppg++;
        //        cli_[2].pppg++ <--> ethernetline_fast <--> rte[0].pppg++;
        //        cli_[3].pppg++ <--> ethernetline_fast <--> rte[0].pppg++;
        //        cli_[4].pppg++ <--> ethernetline_fast <--> rte[0].pppg++;
        //        cli_[5].pppg++ <--> ethernetline_fast <--> rte[0].pppg++;
        //        cli_[6].pppg++ <--> ethernetline_fast <--> rte[0].pppg++;
        //        
        srv.pppg++ <--> fiberline <--> rte[2].pppg++;
}



//package inet.examples.inet.flatnet_mini;
//
//import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
//import inet.node.inet.Router;
//import inet.node.inet.StandardHost;
//import ned.DatarateChannel;
//
//
//network FlatNet_mini
//{
//    types:
//        channel fiberline extends DatarateChannel
//        {
//            delay = 1us;
//            datarate = 512Mbps;
//        }
//        channel ethernetline extends DatarateChannel
//        {
//            delay = 0.1us;
//            datarate = 10Mbps;
//        }
//    submodules:
//        configurator: IPv4NetworkConfigurator {
//            parameters:
//                config = xml("<config><interface hosts='*' address='192.168.x.x' netmask='255.255.x.x'/></config>");
//        }
//        rte[5]: Router {
//            parameters:
//                @display("is=vs");
//        }
//        cli[1]: StandardHost {
//            parameters:
//                @display("i=device/laptop_s");
//        }
//        srv: StandardHost {
//            parameters:
//                @display("i=device/server_s");
//        }
//    connections:
//        cli[0].pppg++ <--> ethernetline <--> rte[0].pppg++;
//        rte[0].pppg++ <--> ethernetline <--> rte[1].pppg++;
//        rte[1].pppg++ <--> ethernetline <--> rte[2].pppg++;
//        rte[2].pppg++ <--> ethernetline <--> rte[3].pppg++;
//        rte[3].pppg++ <--> ethernetline <--> rte[4].pppg++;
////        cli[1].pppg++ <--> ethernetline <--> rte[0].pppg++;
//        srv.pppg++ <--> fiberline <--> rte[4].pppg++;
//}


