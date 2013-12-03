# README

This is the API for vot.io. It works together with [cremalab-ideas-live](https://github.com/cremalab/cremalab-ideas-live) and [engagement-ring](https://github.com/cremalab/engagement-ring) to create the vot.io web application.

## Dependencies

To make sure all the features work, you will have to run multiple commands to get it working.

To run the delayed job daemon, `bin/delayed_job start`

To run the faye server in [cremalab-ideas-live](https://github.com/cremalab/cremalab-ideas-live), `rackup private_pub.ru -s thin -E production`.

## Configuration for Testing

1. Download [cremalab-ideas-live](https://github.com/cremalab/cremalab-ideas-live)
2. Go into the downloaded repo and run the faye server with `rackup private_pub.ru -s thin -E production`
3. Then in suite_api run the tests with `rake test`

## Deploying

To deploy this application, you will need to add a rubber.yml file in in the config/rubber folder. 

Then run `cap rubber:create_staging `

---
