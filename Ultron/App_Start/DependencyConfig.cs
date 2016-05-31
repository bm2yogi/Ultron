using System.Reflection;
using System.Web.Http;
using Autofac;
using Autofac.Integration.WebApi;

namespace Ultron
{
    public class DependencyConfig
    {
        public static void Register(HttpConfiguration config)
        {
            var assemblies = new[] { Assembly.GetExecutingAssembly() };
            var builder = new ContainerBuilder();
            builder.RegisterApiControllers(assemblies);
            builder.RegisterAssemblyTypes(assemblies).AsImplementedInterfaces();

            config.DependencyResolver = new AutofacWebApiDependencyResolver(builder.Build());
        }
    }
}