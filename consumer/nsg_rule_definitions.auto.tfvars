# References
# 

nsg_rule_table = {
	nsg-frontend = { 
		nsg_name					= "nsg-frontend"
    nsg_inbound   = [
      [
        /* name */                          "allow_inbound_ssh",
        /* priority */                      "1000", 
        /* direction */                     "Inbound", 
        /* action */                        "Allow",
        /* protocol */                      "Tcp",
        /* source port range */             "*",
        /* source port ranges */            null,
        /* source address prefix */         "*",
        /* source address prefixes */       null,
        /* destination port range */        "22",
        /* destination port ranges */       null,
        /* destination address prefix */    "*",
        /* destination address prefixes */  null
      ],
      [
        /* name */                          "allow_http",
        /* priority */                      "1100", 
        /* direction */                     "Inbound", 
        /* action */                        "Allow",
        /* protocol */                      "Tcp",
        /* source port range */             "*",
        /* source port ranges */            null,
        /* source address prefix */         "*",
        /* source address prefixes */       null,
        /* destination port range */        "80",
        /* destination port ranges */       null,
        /* destination address prefix */    "10.10.0.0/24",
        /* destination address prefixes */  null
      ],

    ]
    nsg_outbound  = [
		]
  }
}
