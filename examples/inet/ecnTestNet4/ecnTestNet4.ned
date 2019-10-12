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




package inet.examples.inet.ecnTestNet4;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.node.ethernet.Eth100G;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;


network EcnTestNet4
{
    types:
        channel ethernetline_slow extends DatarateChannel
        {
            delay = 10us;
            datarate = 0.0001Mbps;
        }

    submodules:
        configurator: IPv4NetworkConfigurator;
        rte[2]: Router {
            parameters:
                @display("is=vs");
        }
        bottleneck_rte[2]: Router {
            parameters:
                @display("is=vs");
        }
        cli_[2]: StandardHost {
            parameters:
                @display("i=device/laptop_s");
        }
        srv1: StandardHost {
            parameters:
                @display("i=device/server_s;p=397,103");
        }
        srv2: StandardHost {
            parameters:
                @display("i=device/server_s;p=210,103");
        }
        visualizer: IntegratedVisualizer {
            @display("p=267,37");
        }

    connections:

        cli_[0].pppg++ <--> Eth100G <--> bottleneck_rte[0].pppg++;
        cli_[1].pppg++ <--> Eth100G <--> bottleneck_rte[1].pppg++;
        bottleneck_rte[0].pppg++ <--> ethernetline_slow <--> rte[0].pppg++;
        bottleneck_rte[1].pppg++ <--> ethernetline_slow <--> rte[1].pppg++;
        rte[0].pppg++ <--> Eth10M <--> srv2.pppg++;
        rte[1].pppg++ <--> Eth10M <--> srv1.pppg++;
}

