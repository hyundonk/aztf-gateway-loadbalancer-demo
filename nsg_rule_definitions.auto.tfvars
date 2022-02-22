# References
# 

nsg_rule_table = {
	nsg-fortigate = { 
		nsg_name					= "nsg-fortigate"
    nsg_inbound   = [
      [
        /* name */                          "unblock_all_tcp_rule",
        /* priority */                      "1000", 
        /* direction */                     "Inbound", 
        /* action */                        "Allow",
        /* protocol */                      "Tcp",
        /* source port range */             "*",
        /* source port ranges */            null,
        /* source address prefix */         "0.0.0.0/0",
        /* source address prefixes */       null,
        /* destination port range */        "0-65535",
        /* destination port ranges */       null,
        /* destination address prefix */    "*",
        /* destination address prefixes */  null
      ],
      [
        /* name */                          "unblock_all_udp_rule",
        /* priority */                      "2000", 
        /* direction */                     "Inbound", 
        /* action */                        "Allow",
        /* protocol */                      "Udp",
        /* source port range */             "*",
        /* source port ranges */            null,
        /* source address prefix */         "0.0.0.0/0",
        /* source address prefixes */       null,
        /* destination port range */        "0-65535",
        /* destination port ranges */       null,
        /* destination address prefix */    "*",
        /* destination address prefixes */  null
      ],
 
    ]
    nsg_outbound  = [
      [
        /* name */                          "unblock_all_tcp_outrule",
        /* priority */                      "1000", 
        /* direction */                     "Outbound", 
        /* action */                        "Allow",
        /* protocol */                      "Tcp",
        /* source port range */             "*",
        /* source port ranges */            null,
        /* source address prefix */         "0.0.0.0/0",
        /* source address prefixes */       null,
        /* destination port range */        "0-65535",
        /* destination port ranges */       null,
        /* destination address prefix */    "*",
        /* destination address prefixes */  null
      ],
 
		]
  }
}
