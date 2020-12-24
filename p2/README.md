# Project 2

### Cost estimates
- [Initial cost estimate](https://calculator.aws/#/estimate?id=ed53e44457d6883caff1b3e7b707a5e0e91625e2) - 9,380.64 USD / month
- [Reduced estimate](https://calculator.aws/#/estimate?id=d41f9aa2909f06c5b026554cc0678017168d1602) - 6,464.21 USD / month
  - Reduced instance size of web and app servers to t3.medium, and increased the limit of autoscaling group. Performance will be affected, but this will allow for more granular autoscaling
  - Reduced the instance size of RDS postgres instances.
  - Used 1 year standard reserved instances for servers and RDS. This makes sense since we won't be re-architecting the app much.
- [Increased estimate](https://calculator.aws/#/estimate?id=4928ac83950fc19b5c35e88b4294fe34555cb704)
  - Added a secondary region for more redundancy and better performance. Web and app servers are of same type in both regions, but the secondary region only has a Multi-AZ read replica which is updated from the primary main DB.
  - Increased server instance sizes for better performance
  - Servers in secondary region can write to the primary main DB through VPC peering