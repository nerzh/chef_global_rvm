# global_rvm

## Example settings in default_attributes

RVM will be added to root and other users

```ruby
    "global_rvm": {
      "rvm_path": "/usr/local",
      "rvmrc": {
        "rvm_gem_options": "--no-rdoc --no-ri",
        "rvm_autoupdate_flag": 0
      },
      "install_requirements" : "true",
      "users": [
        "dev"
      ],
      "rubies": {
        "2.3.3": {
          "gems": [
            {"bundler": "latest"}
          ]
        },
        "2.4.1": {
          "gems": [
            {"bundler": "latest"},
            {"rails": "latest"}
          ],
          "gemsets": [
            "saletoys"
          ]  
        }
      }
    }
```

