# Unbound

An Unbound container with automatic root-hint file updates.

## Usage

Here are some example snippets to help you get started creating a container.

### Docker Compose

```yaml
version: "3.1"
services:
  unbound:
    image: dextertanyj/unbound
    container_name: unbound
    cap_add:
      - NET_ADMIN
    restart: unless-stopped
```

### Docker CLI

```bash
docker run -d \
  --name unbound \
  --cap-add=NET_ADMIN \
  --restart unless-stopped \
  dextertanyj/unbound
```
