package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func testVirtualService(t *testing.T, variant string) {
	t.Parallel()

	terraformDir := fmt.Sprintf("../examples/%s", variant)

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	id := terraform.Output(t, terraformOptions, "id")
	arn := terraform.Output(t, terraformOptions, "arn")
	name := terraform.Output(t, terraformOptions, "name")

	region := getAWSRegion(t)
	accountID := getAWSAccountID(t)

	expectedName := fmt.Sprintf("example-tf-virtual-service-%s", variant)
	expectedARN := fmt.Sprintf("arn:aws:appmesh:%s:%s:mesh/%s/virtualService/%s", region, accountID, expectedName, expectedName)

	assert.NotEqual(t, nil, id)
	assert.Equal(t, expectedName, name)
	assert.Equal(t, expectedARN, arn)
}
