// dotnet tool install -g dotnet-script
// dotnet script 5.2.cs

string filename = "input/5.txt";

string[] lines = File.ReadAllLines(filename);

List<Tuple<int, int>> orders = new List<Tuple<int, int>>();
List<List<int>> updates = new List<List<int>>();
bool section = false;

foreach (string line in lines)
{
    if (line.Length == 0)
    {
        section = true;
        continue;
    }

    if (section)
    {
        List<int> update = line.Split(',').Select(int.Parse).ToList();
        updates.Add(update);
    }
    else
    {
        Tuple<int, int> order = new Tuple<int, int>(int.Parse(line.Split('|')[0]), int.Parse(line.Split('|')[1]));
        orders.Add(order);
    }
}

int sum = 0;

foreach (List<int> update in updates)
{
    bool valid = true;

    foreach (Tuple<int, int> order in orders)
    {
        if (update.Contains(order.Item1) && update.Contains(order.Item2))
        {
            if (update.IndexOf(order.Item1) > update.IndexOf(order.Item2))
            {
                valid = false;
                break;
            }
        }
    }

    if (!valid)
    {
        List<Tuple<int, int>> ordersf = orders.Where(order => update.Contains(order.Item1) && update.Contains(order.Item2)).ToList();
        Dictionary<int, List<int>> g = new Dictionary<int, List<int>>();
        HashSet<int> n = new HashSet<int>(update);

        foreach (var node in n)
            g[node] = new List<int>();

        foreach (var order in ordersf)
        {
            g[order.Item1].Add(order.Item2);
        }

        HashSet<int> visited = new HashSet<int>();
        Stack<int> stack = new Stack<int>();

        foreach (int node in update)
        {
            if (!visited.Contains(node))
            {
                visited.Add(node);

                foreach (int neighbor in g[node])
                {
                    if (!visited.Contains(neighbor))
                    {
                        TSort(neighbor, g, visited, stack);
                    }
                }

                stack.Push(node);
            }
        }

        List<int> newUpdate = stack.Reverse().ToList();

        sum += newUpdate[newUpdate.Count / 2];
    }
}

Console.WriteLine(sum);

// recursive sort function
static void TSort(int node, Dictionary<int, List<int>> g, HashSet<int> visited, Stack<int> stack)
{
    visited.Add(node);

    foreach (int neighbor in g[node])
    {
        if (!visited.Contains(neighbor))
        {
            TSort(neighbor, g, visited, stack);
        }
    }

    stack.Push(node);
}
