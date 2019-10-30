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




package inet.examples.inet.ecnTestNet6;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.node.ethernet.Eth100G;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;



network EcnTestNet6
{
    types:
        channel ethernetline extends DatarateChannel
        {
            delay = 0.1us;
            datarate = 100Mbps;
        }
        channel gigabitline2 extends DatarateChannel
        {
            delay = 0.1us;
            datarate = 1Gbps;
        }

    submodules:
        configurator: IPv4NetworkConfigurator;
        rte[5]: Router {
            parameters:
                @display("is=vs");
        }
        rte_afterBottle: Router {
            parameters:
                @display("is=vs");
        }
        bottleneck_rte: Router {
            parameters:
                @display("is=vs");
        }
        cli[5]: StandardHost {
            parameters:
                @display("i=device/laptop_s");
        }
        srv: StandardHost {
            parameters:
                @display("i=device/server_s;p=397,103");
        }
        visualizer: IntegratedVisualizer {
            @display("p=267,37");
        }

    connections:
		for i=0..5-1{
			cli[i].pppg++ <--> ethernetline <--> rte[i].pppg++;
        	rte[i].pppg++ <--> ethernetline <--> bottleneck_rte.pppg++;
		}
		bottleneck_rte.pppg++ <--> ethernetline <--> rte_afterBottle.pppg++;
		rte_afterBottle.pppg++ <--> ethernetline <--> srv.pppg++;
}