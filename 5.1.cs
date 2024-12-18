// dotnet tool install -g dotnet-script
// dotnet script 5.1.cs

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

    if (valid)
    {
        sum += update[update.Count / 2];
    }

}

Console.WriteLine(sum);