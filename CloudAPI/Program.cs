using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace CloudAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IWebHostBuilder CreateHostBuilder(string[] args)
        {
            var DefaultHost = Environment.GetEnvironmentVariable("DEFAULT_HOST");
            var EnvConfig = Environment.GetEnvironmentVariable("ENV_CONFIG");
            var builder =  WebHost.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration(ic => 
                    ic.AddJsonFile(!String.IsNullOrWhiteSpace(EnvConfig) ? EnvConfig : "appsettings.Development.json")
                ).UseUrls(!String.IsNullOrWhiteSpace(DefaultHost) ? DefaultHost : "http://0.0.0.0:80")
                .UseStartup<Startup>();
            return builder;
        }
    }
}
