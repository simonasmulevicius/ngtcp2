# These instructions specify how to setup testing environment
# which can reorder packets.

# 1. Initial setup:
# 1.1 Server side (reorders outgoing traffic):
tc qdisc add dev nf1 root netem gap 3 delay 100ms reorder 100%

# 1.2 Client side (delays outgoing traffic):
tc qdisc add dev eth2 root netem delay 100ms


# 2. Other frequently used commands
# 2.1 Delete old rules
tc qdisc del dev nf1 root

# 2.2 Get a list of rules for specific interface
tc -p qdisc ls dev nf1
