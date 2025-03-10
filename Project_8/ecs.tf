# Getting data existed ECR
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.12.0"

  cluster_name = "ecs-cluster"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
    }
   }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }
  

  services = {
    flask-app = {
      cpu    = 256
      memory = 512
      desired_count = 2
      
      # Container definition(s)
      container_definitions = {

        flask-app = {
          cpu       = 256
          memory    = 512
          essential = true
          image     = var.ecr_repo_name
          port_mappings = [
            {
              name          = "flask-app"
              containerPort = 5000
              hostPort      = 5000
              protocol      = "tcp"
            }
          ]
        
      

        # Example image used requires access to write to root filesystem
        readonly_root_filesystem = false
        }
      }

        load_balancer = {
          service = {
            target_group_arn = module.alb.target_groups["ex_ecs"].arn
            container_name   = "flask-app"
            container_port   = 5000
          }
        }

        subnet_ids = module.vpc.private_subnets
        security_group_rules = {
        alb_ingress_3000 = {
          type                     = "ingress"
          from_port                = 5000
          to_port                  = 5000
          protocol                 = "tcp"
          description              = "Service port"
          source_security_group_id = module.alb.security_group_id
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }    

  
    
    tags = {
      name = "flask-app"
    }
}

