resource "aws_iam_user" "users" {
    count = length(var.iamusers)
    name = var.iamusers[count.index]
    # create_iam_access_key         = true
    # iam_access_key_status         = "Inactive"
}

# resource "aws_iam_user_policy" "iam" {
#     count = length(var.iamusers)
#     name = "ListBuckets"
#     user = var.iamusers[count.index]
#     policy = file("policy/student_iam_policy.json")
# }

# resource "aws_iam_user_login_profile" "u" {
#   count = length(var.iamusers)
#   user = var.iamusers[count.index]
#   password_reset_required = true
#   pgp_key                 = "${base64encode(file("/Terraform_practice/iam_terra/oli.gpg.pubkey"))}"

#   # pgp_key = "keybase:deekshithsn"
# }

# output "password" {
#   value = "${aws_iam_user_login_profile.u.encrypted_password}"
# }