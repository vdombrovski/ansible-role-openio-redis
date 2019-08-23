class FilterModule(object):
    def filters(self):
        return {
            'redis_master_property': self.redis_master_property,
        }

    def redis_master_property(self, fact, property='master_host', redis_type='redis', namespace='OPENIO', service=None, monitor_name='OPENIO-master-1'):

        if redis_type == 'redis':
            return self._redis_master_property_redis(fact, property=property, namespace=namespace, service=service)
        if redis_type == 'redissentinel':
            return self._redis_master_property_sentinel(fact, property=property, namespace=namespace, service=service, monitor_name=monitor_name)
        return ''



    def _redis_master_property_redis(self, fact, property='master_host', namespace='OPENIO', service=None):
        for instance in fact.get('instances', []):
            if instance['namespace'] == namespace and instance['service'] == service:
                if "master_host" in instance:
                    return instance[property]
                if "role" in instance and instance['role'] == 'master':
                    return instance.get('bind')
        return ''


    def _redis_master_property_sentinel(self, fact, property='master_host', namespace='OPENIO', service=None, monitor_name='OPENIO-master-1'):
        for instance in fact.get('instances', []):
            if instance['namespace'] == namespace and instance['service'] == service:
                for monitor in instance.get('monitors', []):
                    if "name" in monitor:
                        if monitor["name"] == monitor_name:
                            return monitor[property]
        return ''
