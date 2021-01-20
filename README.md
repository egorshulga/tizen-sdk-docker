# tizen-sdk-docker

Image for building Tizen apps (`.wgt`).

Tizen SDK uses `gnome-keyring` to store certificate passwords, which requires [IPC_LOCK capability](https://man7.org/linux/man-pages/man7/capabilities.7.html).

Add this capability when running the image:

```
docker run -it --cap-add IPC_LOCK egorshulga/tizen-sdk
```

To use the image in Gitlab, `IPC_LOCK` capability should be added in runner configuration file `config.toml` to [[runners.docker]](https://docs.gitlab.com/runner/configuration/advanced-configuration.html#the-runnersdocker-section) section:

```
[[runners]]
  name = ...
  executor = "docker"
  [runners.docker]
    cap_add = ["IPC_LOCK"]
    ...
```

## Building Tizen web app

Add author security profile for signing the application:

```
tizen security-profiles add --name <PROFILE_NAME> --ca <AUTHOR_CRT_PATH> --author <AUTHOR_P12_PATH> --password <AUTHOR_PASSWORD>
```

To pack `.wgt` (you may need to compile it first, e.g. if you use TypeScript):

```
tizen package --type wgt --sign <PROFILE_NAME> -- <SOURCES_ROOT>
```
