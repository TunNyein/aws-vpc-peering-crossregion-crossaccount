
provider "aws" {
  # Configuration options
  profile = "account-A"
  region  = "ap-southeast-1"
  alias   = "account-A"
}

provider "aws" {
  # Configuration options
  profile = "account-B"
  region  = "ap-northeast-1"
  alias   = "account-B"
}
