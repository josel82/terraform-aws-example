
# Retrieve IAMReadOnlyAccess to referece arn int the role policy attachment
data "aws_iam_policy" "iam-ro-access" {
  name = "IAMReadOnlyAccess"
}

# Attach IAMReadOnlyAccess policy to myIAMRole defined below
resource "aws_iam_role_policy_attachment" "my-policy-attachment" {
  role = aws_iam_role.my-iam-role.name
  policy_arn = data.aws_iam_policy.iam-ro-access.arn
}

# Create the role to be assigned to the EC2 instance
resource "aws_iam_role" "my-iam-role" {
  name = "myIAMRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
#This is what attaches the role to the instance
resource "aws_iam_instance_profile" "iam-ro-inst-pfl" {
  name = "iam-ro-inst-pfl"
  role = aws_iam_role.my-iam-role.name
}