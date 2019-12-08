package inet.examples.inet.simulation4;

import inet.networklayer.configurator.ipv4.IPv4NetworkConfigurator;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;

network Simulation4
{
    submodules:
        configurator: IPv4NetworkConfigurator;
        server: StandardHost {
            parameters:
                @display("i=device/server_s;p=20,250");
        }

        R1: Router {
            parameters:
                @display("is=vs;p=100,250");
        }

        R2: Router {
            parameters:
                @display("is=vs;p=180,250");
        }

        ECN_ON: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,175");
        }

        ECN_OFF1: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,225");
        }

        ECN_OFF2: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,275");
        }

        ECN_OFF3: StandardHost {
            parameters:
                @display("i=device/laptop_s;p=280,325");
        }

        visualizer: IntegratedVisualizer {
            @display("");
        }

    connections:
        server.pppg++ <--> Eth100M <--> R1.pppg++;
        R1.pppg++ <--> Eth10M { @display("ls=blue,3;t=bottleneck"); } <--> R2.pppg++;
        R2.pppg++ <--> Eth100M <--> ECN_ON.pppg++;
        R2.pppg++ <--> Eth100M <--> ECN_OFF1.pppg++;
        R2.pppg++ <--> Eth100M <--> ECN_OFF2.pppg++;
        R2.pppg++ <--> Eth100M <--> ECN_OFF3.pppg++;

}
