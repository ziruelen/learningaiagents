using System;
using System.ComponentModel;
using System.Threading.Tasks;
using Azure.AI.OpenAI;
using Azure.Identity;
using Microsoft.Agents.AI;
using Microsoft.Extensions.AI;

public class Program
{
    [Description("Devuelve un estimado simulado de un metric de homelab.")]
    public static string GetHomelabMetric(
        [Description("Nombre del metric: cpu, ram o disk.")] string metricName)
    {
        var m = (metricName ?? "").Trim().ToLowerInvariant();
        var value = new Random().Next(1, 100);
        return m switch
        {
            "cpu" => $"CPU simulated usage: {value}%",
            "ram" => $"RAM simulated usage: {value}%",
            "disk" => $"DISK simulated usage: {value}%",
            _ => $"{m} simulated value: {value}"
        };
    }

    public static async Task Main(string[] args)
    {
        // Variables tipicas en snippets oficiales (ajustalas a tu entorno)
        var endpoint = Environment.GetEnvironmentVariable("AZURE_OPENAI_ENDPOINT")
            ?? throw new InvalidOperationException("Set AZURE_OPENAI_ENDPOINT");

        var deploymentName = Environment.GetEnvironmentVariable("AZURE_OPENAI_DEPLOYMENT_NAME")
            ?? "gpt-4o-mini";

        AIAgent agent = new AzureOpenAIClient(new Uri(endpoint), new AzureCliCredential())
            .GetChatClient(deploymentName)
            .AsAIAgent(
                instructions: "Eres un assistant tecnico de SRE. Usa la tool para metrics.",
                tools: [AIFunctionFactory.Create(GetHomelabMetric)]
            );

        var response = await agent.RunAsync("Estimame CPU y RAM para mis operaciones homelab.");
        Console.WriteLine(response);
    }
}

