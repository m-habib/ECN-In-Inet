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
        channel gigabitline extends DatarateChannel
        {
            delay = 0.1us;
            datarate = 1Gbps;
        }

    submodules:
        configurator: IPv4NetworkConfigurator;
        cli_NSSL[6]: StandardHost {
            parameters:
                @display("i=device/laptop_s");
        }

        cli_TCE[8]: StandardHost;

        cli_VLSI[16]: StandardHost {
            parameters:
                @display("i=device/laptop_s");
        }

        rte_VLSI[2]: Router {
            parameters:
                @display("is=vs");
        }

        rte_faculty[5]: Router {
            parameters:
                @display("is=vs");
        }

        srv: StandardHost {
            parameters:
                @display("i=device/server_s;p=397,103");
        }

        visualizer: IntegratedVisualizer {
            @display("p=267,37");
        }

    connections:
        for i=0..sizeof(cli_NSSL)-1 {
            cli_NSSL[i].pppg++ <--> ethernetline <--> rte_faculty[0].pppg++;
        }
        for i=0..sizeof(cli_TCE)-1 {
            cli_TCE[i].pppg++ <--> ethernetline <--> rte_faculty[1].pppg++;
        }
        for i=0..7 {
            cli_VLSI[i].pppg++ <--> ethernetline <--> rte_VLSI[0].pppg++;
        }
        for i=8..15 {
            cli_VLSI[i].pppg++ <--> ethernetline <--> rte_VLSI[1].pppg++;
        }

        rte_VLSI[0].pppg++ <--> Eth100M <--> rte_faculty[2].pppg++;
        rte_VLSI[1].pppg++ <--> Eth100M <--> rte_faculty[2].pppg++;
        rte_faculty[0].pppg++ <--> Eth100M <--> rte_faculty[3].pppg++;
        rte_faculty[1].pppg++ <--> Eth100M <--> rte_faculty[3].pppg++;
        rte_faculty[3].pppg++ <--> Eth100M <--> rte_faculty[4].pppg++;
        rte_faculty[2].pppg++ <--> Eth100M <--> rte_faculty[4].pppg++;
        rte_faculty[4].pppg++ <--> Eth100M <--> srv.pppg++;


}
